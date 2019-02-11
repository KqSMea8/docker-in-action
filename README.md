# 运行
## 编译

```
make clean
make html
```

会在`build`目录下生成编译后的html文件:

```
├── build
│   ├── doctrees
│   │   ├── docker
│   │   ├── environment.pickle
│   │   └── index.doctree
│   └── html
│       ├── docker
│       ├── genindex.html
│       ├── _images
│       ├── index.html
│       ├── objects.inv
│       ├── search.html
│       ├── searchindex.js
│       ├── _sources
│       └── _static
├── Makefile
├── README.md
├── requirements.txt
├── source
       ├── conf.py
       ├── docker
       │   ├── basic_cmd.md
       │   ├── basic_concept.md
       │   └── intro.md
       ├── index.rst
       ├── _static
       │   ├── docker.png
       │   └── virtualization.png
       └── _templates
```

## 访问

```
cd build/html
python -m SimpleHTTPServer
```

访问`http://localhost:8000`即可。

# 开发

## 创建工程

```
venv/bin/sphinx-quickstart
```

按照提示输入。

创建完成后，工程的配置在 `source/conf.py`。

## 配置

### 支持markdown

* 增加依赖`recommonmark==0.5.0`
* 修改 `conf.py`:
    * `import recommonmark`
    * `extensions`增加markdown支持，追加`recommonmark`。
        ```
        extensions = [
            'sphinx.ext.todo',
            'sphinx.ext.mathjax',
            'recommonmark'
        ]
        ```
    * `source_suffix`增加 `.md`。
        ```
        source_suffix = ['.rst', '.md']
        ```
        
### 定制主题

* 增加依赖`sphinx_rtd_theme==0.4.2`
* 修改`conf.py`中`html_theme`为`sphinx_rtd_theme`。
    ```
    html_theme = 'sphinx_rtd_theme'
    ```
