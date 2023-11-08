Extension { #name : 'BlElement' }

{ #category : '*Toplo-Theme-Bee' }
BlElement >> defaultBeeStyleStamps [

	^ #( )
]

{ #category : '*Toplo-Theme-Bee' }
BlElement >> initialBeeStyle [ 
]

{ #category : '*Toplo-Theme-Bee' }
BlElement >> installBeeStyle [ 

]

{ #category : '*Toplo-Theme-Bee' }
BlElement >> textAttributesBuilder [

	^ self userData at: #textAttributesBuilder ifAbsentPut: [ BlTextAttributesBuilder new ]
]

{ #category : '*Toplo-Theme-Bee' }
BlElement >> uninstallBeeStyle [
]
