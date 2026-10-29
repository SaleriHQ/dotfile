function mj --description '创建简洁的 Maven + JUnit 项目'
    if test (count $argv) -ne 1
        echo "用法：mj <项目名>"
        echo "示例：mj Ex4"
        return 1
    end

    set -l artifact_id "$argv[1]"

    if not string match -rq '^[A-Za-z][A-Za-z0-9]*$' -- "$artifact_id"
        echo "错误：项目名必须以字母开头，并且只能包含字母和数字"
        echo "当前名称：$artifact_id"
        return 1
    end

    set -l lower_id (string lower -- "$artifact_id")
    set -l group_id "com.$lower_id"
    set -l project_dir "$PWD/$artifact_id"

    if test -e "$project_dir"
        echo "错误：目标已经存在：$project_dir"
        return 1
    end

    mkdir -p "$project_dir/src" "$project_dir/test"
    or return 1

    printf '%s\n' \
                  '<?xml version="1.0" encoding="UTF-8"?>' \
                  '<project xmlns="http://maven.apache.org/POM/4.0.0"' \
                  '         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' \
                  '         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
          https://maven.apache.org/xsd/maven-4.0.0.xsd">' \
                  '    <modelVersion>4.0.0</modelVersion>' \
                  '' \
                  "    <groupId>$group_id</groupId>" \
                  "    <artifactId>$artifact_id</artifactId>" \
                  '    <version>1.0-SNAPSHOT</version>' \
                  '' \
                  '    <properties>' \
                  '        <maven.compiler.release>17</maven.compiler.release>' \
                  '        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>' \
                  '    </properties>' \
                  '' \
                  '    <dependencies>' \
                  '        <dependency>' \
                  '            <groupId>junit</groupId>' \
                  '            <artifactId>junit</artifactId>' \
                  '            <version>4.13.2</version>' \
                  '            <scope>test</scope>' \
                  '        </dependency>' \
                  '    </dependencies>' \
                  '' \
                  '    <build>' \
                  '        <sourceDirectory>${project.basedir}/src</sourceDirectory>' \
                  '        <testSourceDirectory>${project.basedir}/test</testSourceDirectory>' \
                  '        <plugins>' \
                  '            <plugin>' \
                  '                <groupId>org.apache.maven.plugins</groupId>' \
                  '                <artifactId>maven-compiler-plugin</artifactId>' \
                  '                <version>3.14.1</version>' \
                  '            </plugin>' \
                  '            <plugin>' \
                  '                <groupId>org.apache.maven.plugins</groupId>' \
                  '                <artifactId>maven-surefire-plugin</artifactId>' \
                  '                <version>3.6.0</version>' \
                  '            </plugin>' \
                  '        </plugins>' \
                  '    </build>' \
                  '</project>' > "$project_dir/pom.xml"
    or return 1

    echo "Maven 项目初始化完成："
    echo "  位置：       $project_dir"
    echo "  groupId:    $group_id"
    echo "  artifactId: $artifact_id"
    echo ""
    echo "正式代码：$artifact_id/src/"
    echo "测试代码：$artifact_id/test/（测试类名称应以 Test 结尾）"
    echo "运行测试：cd $artifact_id && mvn test"
end
