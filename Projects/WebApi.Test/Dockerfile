FROM microsoft/aspnetcore-build:2.0 AS build
WORKDIR /app

ENV ASPNETCORE_URLS="http://*:80"
EXPOSE 80/tcp

# copy source and test projects as distinct layers
COPY . ./
RUN dotnet restore WebApi.Test.sln --source https://api.nuget.org/v3/index.json

# copy everything else and build
RUN dotnet publish ./src/WebApi.Test/WebApi.Test.csproj -c Release -o /output --no-restore

# build runtime image
FROM microsoft/aspnetcore:2.0 as runtime
WORKDIR /app
COPY --from=build /output .
ENTRYPOINT ["dotnet", "WebApi.Test.dll"]
