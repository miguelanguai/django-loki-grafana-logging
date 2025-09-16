import logging

from django.http import HttpResponse
from django.views import View

logger = logging.getLogger(__name__)


class MiVista(View):
    def get(self):
        """Método GET de prueba"""
        logger.info("método GET llamado")
        logger.error("error mostrado al llamar al GET")
        return HttpResponse("hola desde get")
