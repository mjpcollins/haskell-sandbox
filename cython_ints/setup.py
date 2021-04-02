from setuptools import setup
from Cython.Build import cythonize

setup(
    name='Comparison',
    ext_modules=cythonize("compare.pyx"),
    zip_safe=False,
)

# Compile with: python setup.py build_ext --inplace

