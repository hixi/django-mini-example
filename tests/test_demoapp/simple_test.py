import pytest

from demoapp.models import Demo


@pytest.fixture
def demo_data(transactional_db):
    return {"name": "example"}


@pytest.fixture
def demo_obj(transactional_db, demo_data):
    return Demo.objects.create(**demo_data)


@pytest.mark.django_db
def test_simple(demo_obj, demo_data):
    assert demo_obj.name == demo_data["name"]
