# Module web NovaSphere

Module issu des ressources de S4 : Security Group web, Launch Template et Auto Scaling Group.
Le VPC et l'ALB sont fournis par le projet principal.

Les instances acceptent HTTP uniquement depuis le Security Group de l'ALB. Aucun port SSH.
Le Launch Template impose IMDSv2 et recoit un profil IAM et un script sans secret.
L'ASG utilise les controles de sante ELB et garde au moins deux instances.

Variables : environnement, VPC, subnets, SG de l'ALB, target group, AMI, type d'instance,
profil IAM, script de demarrage et tailles de l'ASG.
Outputs : identifiant du SG, identifiant du Launch Template, nom de l'ASG.

Le projet principal appelle ce module depuis Git avec le tag v1.0.0 (S2 et S3).
