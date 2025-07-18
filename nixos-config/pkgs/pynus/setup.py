
from distutils.core import setup

setup(
    name='pynus',
    version='0.1',
    description='Tool to talk to a micropython via NUS',
    packages=['pynus'],
    install_requires=[
        # 'dbus-python',
        'PyGObject'
    ],
    entry_points={
        "console_scripts": [
            "pynus = pynus.pynus:main",
        ]
    }
)

