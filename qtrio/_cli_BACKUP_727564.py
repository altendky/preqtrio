import click


@click.group()
def cli():
<<<<<<< HEAD
=======
    """QTrio - a library bringing Qt GUIs together with async and await via Trio"""

>>>>>>> master
    pass


@cli.group()
def examples():
<<<<<<< HEAD
=======
    """Run code examples."""

>>>>>>> master
    pass


@examples.command()
<<<<<<< HEAD
@click.option("--url", help="The URL to download.")
@click.option(
    "--destination",
    help="The file path to save to.",
    type=click.Path(dir_okay=False, writable=True, resolve_path=True, allow_dash=True),
)
@click.option(
    "--fps",
    default=60,
    help="Frames per second for progress updates.",
    type=click.IntRange(min=1),
)
def download(url, destination, fps):
    import qtrio.examples.download

    qtrio.run(qtrio.examples.download.main, url, destination, fps)
=======
def emissions():  # pragma: no cover
    """A simple demonstration of iterating over signal emissions."""

    import qtrio.examples.emissions

    qtrio.run(qtrio.examples.emissions.main)
>>>>>>> master
