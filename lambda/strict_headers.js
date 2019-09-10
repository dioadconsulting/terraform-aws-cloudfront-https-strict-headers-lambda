// initially imported from https://aws.amazon.com/blogs/networking-and-content-delivery/adding-http-security-headers-using-lambdaedge-and-amazon-cloudfront/

'use strict';


exports.handler = (event, context, callback) => {
    
  //Get contents of response
  const response = event.Records[0].cf.response;
  const headers = response.headers;

  //Set new headers 
  // https://infosec.mozilla.org/guidelines/web_security#http-strict-transport-security
  headers['strict-transport-security'] = [
    {
      key: 'Strict-Transport-Security',
      value: 'max-age=63072000; includeSubdomains; preload'
    }
  ]; 

  // https://infosec.mozilla.org/guidelines/web_security#content-security-policy
  headers['content-security-policy'] = [
    {
      key: 'Content-Security-Policy',
      value: "default-src none; img-src 'self'; script-src 'self'; style-src 'self'; object-src 'none'"
    }
  ]; 

  // https://infosec.mozilla.org/guidelines/web_security#x-content-type-options
  headers['x-content-type-options'] = [
    {
      key: 'X-Content-Type-Options', value: 'nosniff'
    }
  ]; 

  // https://infosec.mozilla.org/guidelines/web_security#x-frame-options
  headers['x-frame-options'] = [
    {
      key: 'X-Frame-Options',
      value: 'DENY'
    }
  ]; 

  // https://infosec.mozilla.org/guidelines/web_security#x-xss-protection
  headers['x-xss-protection'] = [
    {
      key: 'X-XSS-Protection',
      value: '1; mode=block'
    }
  ]; 

  // https://infosec.mozilla.org/guidelines/web_security#referrer-policy 
  headers['referrer-policy'] = [
    {
      key: 'Referrer-Policy',
      value: 'same-origin'
    }
  ]; 
    
  //Return modified response
  callback(null, response);
};
