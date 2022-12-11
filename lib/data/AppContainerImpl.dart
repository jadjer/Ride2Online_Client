/*
 * Copyright 2022 Pavel Suprunov
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'dart:io';

import 'package:ride2online/data/AppContainer.dart';
import 'package:ride2online/data/repositories/auth/AuthRepository.dart';

class AppContainerImpl implements AppContainer {

  @override
  AuthRepository getAuthRepository() {
    throw UnimplementedError();
  }

  HttpClient provideSslOkhttpClient() {
    var certificateAuthority = """
          -----BEGIN CERTIFICATE-----
          MIID8DCCAtigAwIBAgIUDJY6vawcJTtrPwLuDu6HcmiMfS4wDQYJKoZIhvcNAQEL
          BQAwgZExCzAJBgNVBAYTAkJZMRAwDgYDVQQIDAdWaXRlYnNrMRAwDgYDVQQHDAdW
          aXRlYnNrMRIwEAYDVQQKDAlsb2NhbGhvc3QxFDASBgNVBAsMC0RldmVsb3BtZW50
          MRcwFQYDVQQDDA5QYXZlbCBTdXBydW5vdjEbMBkGCSqGSIb3DQEJARYMamFkamVy
          QHlhLnJ1MB4XDTIyMTExNDE2MDIxMVoXDTIzMTExNDE2MDIxMVowgZExCzAJBgNV
          BAYTAkJZMRAwDgYDVQQIDAdWaXRlYnNrMRAwDgYDVQQHDAdWaXRlYnNrMRIwEAYD
          VQQKDAlsb2NhbGhvc3QxFDASBgNVBAsMC0RldmVsb3BtZW50MRcwFQYDVQQDDA5Q
          YXZlbCBTdXBydW5vdjEbMBkGCSqGSIb3DQEJARYMamFkamVyQHlhLnJ1MIIBIjAN
          BgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAmNIrpAA/RRqzHgj6iNNLzZvRjcZf
          nmD9CNFP9POr83OkGARVUBFMZWFlBX5BwimTyvdKI780eBS1AEVBDxTn6FLCGUID
          Jai8niSORSyIMtp6v+dV2ZAPelHtxrh5Z5CcwhMcaJs0XhQxYFg5zgfmMD1Ez2ni
          krIDzb9u99jHZNfK+wuI0d7uiaUDZzeyAl2hmmlZeqZHlV5ssn/ljlUWQoKxP5+n
          PQFlo0Mv96tahGia3btdqG2BU5bRHLjBWfh5JKSz4gML9vvVcuKP5A6H/Eihbo93
          lR1k0tjm3hDwVHH2twP9HP+i6irZyA9eVCRej+mpnmqNuJgvuYG8hK8nXQIDAQAB
          oz4wPDAbBgNVHREEFDAShxAqAiIKIAEXAMSBtf/+louuMB0GA1UdDgQWBBS+/TvP
          GdzbfM1lRDfPLxuI162LQzANBgkqhkiG9w0BAQsFAAOCAQEAazM6W3ZhEqzr4+hS
          jgmPpjC2vhnfwn0fQOb/ouFBR2YfVFKfbbc7KfWfvpfS9LMYUQt2NsukM+uXBBLH
          l58y7wi2J11L39JPfbdYso4zf3+SRIKOaBnMJTnIzu72d0mm+hUckJcvGFCsqhw/
          ftiha5YebgRij/UEGLwZhYXOxPBPeSSsAGbvFzQ4Nqt6YFUKuXUZ/FVZAjSgo0di
          7IwenDTsyZB3QsckmL43vfbvVH58DRFI36FqRCFGbijC8KkOZVqIu7r6V51eS0Zs
          sedTe97VqUqHH/Y4NF/JhegaEwWqI95w3cHIehkF1e3cJvaZ1ZHAryvwjTd/nCdY
          W4Y2KQ==
          -----END CERTIFICATE-----
      """;

    SecurityContext context = SecurityContext();
    context.setTrustedCertificates(certificateAuthority);

    val interceptor = HttpLoggingInterceptor()
    interceptor.setLevel(HttpLoggingInterceptor.Level.BODY)

    val certificates = HandshakeCertificates.Builder()
        .addTrustedCertificate(certificateAuthority)
        .build()

    val httpClient = OkHttpClient.Builder()
        .addInterceptor(AuthorizationInterceptor())
        .addInterceptor(interceptor)
        .sslSocketFactory(certificates.sslSocketFactory(), certificates.trustManager)

      return httpClient.build()
  }


  private fun provideRetrofit(client: OkHttpClient): Retrofit {
  return Retrofit.Builder()
      .baseUrl("https://[2a02:220a:2001:1700:c481:b5ff:fe96:8bae]")
      .addConverterFactory(GsonConverterFactory.create())
      .client(client)
      .build()
  }

}
