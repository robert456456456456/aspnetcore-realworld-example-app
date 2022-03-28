#build container
FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build-env1

#install unzip for Cake
RUN apt-get update
RUN apt-get install -y unzip

WORKDIR /build
COPY . .
RUN ./build.sh

#runtime container
FROM mcr.microsoft.com/dotnet/core/aspnet:2.2

COPY --from=build /build/publish /app
WORKDIR /app

EXPOSE 5000

ENTRYPOINT ["dotnet", "Conduit.dll"]
