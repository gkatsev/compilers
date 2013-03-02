George (Gary) Katsevman
Daniel Bostwick

Comments are handled by creating a new state upong seeing a "/*". In this new state everthing is ignored except another "/*" which increments a comment depth counter which is then decremented everytime a "*/" is found. If a "*/" is found before a "/*" an error is thrown. If there are unmatched comments, the default unknown character error message will fire.

Errors are handled by the default error handling given to us. It was edited to produce a neater error message such as: "illegal character '[' at line 1, pos 5". Other than that, errors are handled as usual.

The default End-of-file is used.
