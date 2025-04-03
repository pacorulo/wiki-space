## Connect to [Astra DB](https://astra.datastax.com/signup?utm_source=google&utm_medium=cpc&utm_campaign=ggl_s_emea_brand&utm_term=datastax%20astra&utm_content=brand-astra&gad_source=1&gclid=CjwKCAiA0rW6BhAcEiwAQH28IuGncWKUjENBEq5O_YOk2pMnWQQGoVv9feWAswdE46qmDPunQxD4XBoCzZYQAvD_BwE) using Maven

I would prefer sometimes to connect through the terminal instead of an IDE like Eclipse, so I use maven from a virtual machine that I dedicate for a particular driver and test cases.

1. Install java-jdk
    ```
    sudo apt install openjdk-11-jre-headless
    ```
    Check version: `java --version`

2. Install Maven

   2.1 Download mvn from [Mvn Apache](https://maven.apache.org/download.html)
   
   2.2 Unzip: `tar xzvf apache-maven-3.9.9-bin.tar.gz`
   
   2.3 Create folder: `mkdir /bin/mvn`

   2.4 Add path: `PATH=/bin/mvn/apache-maven-3.9.9/bin:$PATH`

   2.5 Check version: `mvn -v`

4. Download SCB from Astra

5. Generate an Astra token
    ```
    {
      "clientId": "blablabla",
      "secret": "secret_blablablablablablabla",
      "token": "token_blabla"
    }
    ```
5. Create a `pom.xml` file at the top of your source java folder structure (it will be at the same level of the src folder that will be created on next step)
    ```
    <?xml version="1.0" encoding="UTF-8"?>
    <project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
      <modelVersion>4.0.0</modelVersion>
      <groupId>com.datastax.oss</groupId>
      <artifactId>Jdriver</artifactId>
      <version>1.0</version>
      <packaging>pom</packaging>
      <url>https://github.com/datastax/java-driver</url>
      <name>Jdriver</name>
      <properties>
        <driver.version>4.17.0</driver.version>
        <maven.compiler.source>8</maven.compiler.source>
        <maven.compiler.target>8</maven.compiler.target>
      </properties>
      <dependencies>
        <dependency>
          <groupId>com.datastax.oss</groupId>
          <artifactId>java-driver-core</artifactId>
          <version>${driver.version}</version>
        </dependency>
        <dependency>
          <groupId>com.datastax.oss</groupId>
          <artifactId>java-driver-query-builder</artifactId>
          <version>${driver.version}</version>
        </dependency>
        <dependency>
          <groupId>com.datastax.oss</groupId>
          <artifactId>java-driver-mapper-runtime</artifactId>
          <version>${driver.version}</version>
        </dependency>
      </dependencies>
      <build>
       <plugins>
        <plugin>
        <artifactId>maven-compiler-plugin</artifactId>
         <version>3.8.1</version>
         <executions>
          <execution>
           <phase>test</phase>
           <configuration>
            <mainClass>com.datastax.oss.jdriver</mainClass>
           </configuration>
          </execution>
         </executions>
        </plugin>
       </plugins>
      </build>
    </project>
    ```


6. Create java folder structure
    ```
    mkdir -p src/main/java
    ```

7. Create the java `Jdriver.java` file under previous folder
    ```
    package com.datastax.astra;
    
    import com.datastax.oss.driver.api.core.CqlSession;
    import com.datastax.oss.driver.api.core.cql.ResultSet;
    import com.datastax.oss.driver.api.core.cql.Row;
    import java.nio.file.Paths;
    
    public class Jdriver {
    
      public static void main(String[] args) {
    
        // The Session is what you use to execute queries. It is thread-safe and should be reused
        try (CqlSession session = CqlSession.builder()
          .withCloudSecureConnectBundle(Paths.get("/path_to_scb/secure-connect-java.zip"))
          .withAuthCredentials("${clientid}","${token}")
          .build()) {
          // We use execute to send a query to Cassandra. This returns a ResultSet, which
          // is essentially a collection of Row objects
          ResultSet rs = session.execute("select release_version from system.local");
          //  Extract the query output
          Row row = rs.one();
    
          // Extract the value of the first (and only) column from the row
          assert row != null;
          String releaseVersion = row.getString("release_version");
          System.out.println("###########################################################");
          System.out.println("###########################################################");
          System.out.println("###########################################################");
          System.out.println("###########################################################");
          System.out.println("###########################################################");
          System.out.printf("Cassandra version is: %s%n", releaseVersion);
          System.out.println("###########################################################");
          System.out.println("###########################################################");
          System.out.println("###########################################################");
          System.out.println("###########################################################");
          System.out.println("###########################################################");
        }
        System.exit(0);
      }
    }
    ```

8. Almost done as we just have to execute mvn with the parameters/in the way:
   ```
   mvn compile exec:java -Dexec.mainClass="com.datastax.astra.Jdriver"
   ```
