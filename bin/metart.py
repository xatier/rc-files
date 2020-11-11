import random
import textwrap

import httpx

URL_BASE = random.choice(
    [
        'https://domai.com',
        'https://eroticbeauty.com',
        'https://errotica-archives.com',
        'https://live.tv',
        'https://metart.com',
        'https://metartx.com',
        'https://sexart.com',
        'https://thelifeerotic.com',
        'https://vivthomas.com',
        'https://www.domai.com',
        'https://www.goddessnudes.com',
        'https://www.metartx.com',
    ],
)

CDN_BASE = 'https://cdn.metartnetwork.com'
API_URL = f'{URL_BASE}/api/updates?tab=stream&page=1'


def fetch() -> str:
    j = httpx.get(API_URL).json()

    content = ''
    for g in j.get('galleries'):
        img_src = f'{CDN_BASE}/{g["siteUUID"]}{g["coverCleanImagePath"]}'
        model_name, model_url = g["models"][0]["name"], g["models"][0]["path"]

        content += (
            f'<a href="{URL_BASE}{model_url}" target="_blank">'
            f'<img src="{img_src}" alt="{model_name}" '
            'width="540" height="800">'
            '</a>\n'
        )

    return content


def render(content: str) -> None:
    header = textwrap.dedent(
        """
    <html>
        <head>
        </head>
        <body>
            <div class="page">
    """,
    )

    footer = textwrap.dedent(
        """
            </div>
        </body>
    </html>
    """,
    )

    print(header)
    print(content)
    print(footer)


if __name__ == '__main__':
    render(fetch())
