Extension { #name : #BlCornerRadii }

{ #category : #'*Toplo' }
BlCornerRadii >> radiusForDirectionX: dx directionY: dy [
	"Renvoie le rayon du coin le plus proche en fonction de la direction signée.
    dx et dy sont les composantes (cos, sin) d'un angle en radians."

	^ (0 between: dy and: dx)
		  ifTrue: [ self topRight ]
		  ifFalse: [
				  (dx < 0 and: [ dy <= 0 ])
					  ifTrue: [ self topLeft ]
					  ifFalse: [
							  (dx < 0 and: [ dy > 0 ])
								  ifTrue: [ self bottomLeft ]
								  ifFalse: [ self bottomRight ] ] ]
]
