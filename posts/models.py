from django.db import models

class Post(models.Model):
    titulo = models.CharField(max_length=200)
    conteudo = models.TextField()  
    data_postagem = models.DateTimeField(auto_now_add=True)  
    poster_url = models.URLField(max_length=500, blank=True, null=True)
    def __str__(self):
        return self.titulo  
