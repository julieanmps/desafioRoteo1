const axios = require("axios").default;
const qs = require("qs");

async function _freteCall(context, ffVariables) {
  var body = ffVariables["body"];

  var url = `https://www.melhorenvio.com.br/api/v2/me/shipment/calculate`;
  var headers = {
    Authorization: `Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNzE5MWI1NGVjYWFiYTdhOTljZmFjYzdmYmYzM2M3Njk5MTk3NDkyODA5YzcyZjM4YTgwNTMwMTcxMTZjMmFjMDYyODY5MTM0ZmVkOGYyMDYiLCJpYXQiOjE3MzkxMzc1NDQuNDUwNTk0LCJuYmYiOjE3MzkxMzc1NDQuNDUwNTk2LCJleHAiOjE3NzA2NzM1NDQuNDQwMTkxLCJzdWIiOiI5ZTJjNzIyOS1mNzBiLTRmYTAtOTFmYi1lMTAxNzZhMTg5OTQiLCJzY29wZXMiOlsic2hpcHBpbmctY2FsY3VsYXRlIl19.Cgf5Xv-x1jTQFueayppwS8igPUl1xqqbws0Cojid-ibsnLsQnO9MO-nyL9k255ZIBQB_Vs-FKl-PZE2RjnCOIJDe-EF1j0aRMqIPCYhdY4PqiFNWekKZkXoVxbA05AQEyIf7Q1dMADrefPBPBpo11QMv21OWrvnxmRbI-SLPmp3DmRjncCnO7ucE-c2GC738iCBOhYeRMLl5Lo_hP5aT-J0ymoikemguiyyN_crqK1N_t0rpDUT_HfgAks3fmF1EgpeYu9V8cAEi_Y_dOt3KMRo8un3YnXvr3CKGvyyfd3m8ZDQ_wWvhnFqbu82YulDuqJEjd7VJIyQ07WUVSfgm_oL-6QpQ_qpVIvwHE6Ye-NiH0ZNq380mKndxlJ7TnOopc5Ln_WGiD0oYi6Lq6oB4-aBVZ4bGe0N-09alBkfnANNn77vNmMWzsusCOzu7oKSLbVoBFMnFBhZhGR5Pp14mt7rPfIUG3ccaDeiEMqqe6HoiT9BP-h69oH8vNb8_STLzugc6OR9GHSbKPKFTCpBZcI7yRFalXhF3puaIpcB0NwVXIWvf-yhcx-DSKOJDwhSo4UjYclCwuL_lt_LYOOttqY3JRv3fRryPL20tXucQnLih4EMGtgjujQcUDbmbvypPhPlHRVbpSy2TMrzUaYKOP9q2EULuHYk3JOW8a6q7tw4`,
    "Content-Type": `application/json`,
    Accept: `application/json`,
    "User-Agent": `julieanmps@gmail.com`,
  };
  var params = {};
  var ffApiRequestBody = `
${body}`;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    body: createBody({
      headers,
      params,
      body: ffApiRequestBody,
      bodyType: "JSON",
    }),
    returnBody: true,
    isStreamingApi: false,
  });
}

/// Helper functions to route to the appropriate API Call.

async function makeApiCall(context, data) {
  var callName = data["callName"] || "";
  var variables = data["variables"] || {};

  const callMap = {
    FreteCall: _freteCall,
  };

  if (!(callName in callMap)) {
    return {
      statusCode: 400,
      error: `API Call "${callName}" not defined as private API.`,
    };
  }

  var apiCall = callMap[callName];
  var response = await apiCall(context, variables);
  return response;
}

async function makeApiRequest({
  method,
  url,
  headers,
  params,
  body,
  returnBody,
  isStreamingApi,
}) {
  return axios
    .request({
      method: method,
      url: url,
      headers: headers,
      params: params,
      responseType: isStreamingApi ? "stream" : "json",
      ...(body && { data: body }),
    })
    .then((response) => {
      return {
        statusCode: response.status,
        headers: response.headers,
        ...(returnBody && { body: response.data }),
        isStreamingApi: isStreamingApi,
      };
    })
    .catch(function (error) {
      return {
        statusCode: error.response.status,
        headers: error.response.headers,
        ...(returnBody && { body: error.response.data }),
        error: error.message,
      };
    });
}

const _unauthenticatedResponse = {
  statusCode: 401,
  headers: {},
  error: "API call requires authentication",
};

function createBody({ headers, params, body, bodyType }) {
  switch (bodyType) {
    case "JSON":
      headers["Content-Type"] = "application/json";
      return body;
    case "TEXT":
      headers["Content-Type"] = "text/plain";
      return body;
    case "X_WWW_FORM_URL_ENCODED":
      headers["Content-Type"] = "application/x-www-form-urlencoded";
      return qs.stringify(params);
  }
}

module.exports = { makeApiCall };
