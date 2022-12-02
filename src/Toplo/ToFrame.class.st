"
I'm a container with a Frame layout. (see `BlFrameLayout` comments)
"
Class {
	#name : #ToFrame,
	#superclass : #ToElement,
	#traits : 'TToWidget',
	#classTraits : 'TToWidget classTrait',
	#category : #'Toplo-Widget-Frame'
}

{ #category : #'t - initialization' }
ToFrame >> defaultLayout [

	^ BlFrameLayout new 
]

{ #category : #accessing }
ToFrame >> horizontalAlignment [
	<return: #BlElementAlignment>

	^ self layout horizontalAlignment 
]

{ #category : #accessing }
ToFrame >> horizontalAlignment: aBlElementAlignment [

	self horizontalAlignment = aBlElementAlignment ifTrue: [ ^self ].
	self layout horizontalAlignment: aBlElementAlignment.

]

{ #category : #accessing }
ToFrame >> verticalAlignment [
	<return: #BlElementAlignment>

	^ self layout verticalAlignment 
]

{ #category : #accessing }
ToFrame >> verticalAlignment: aBlElementAlignment [

	self verticalAlignment = aBlElementAlignment ifTrue: [ ^self ].
	self layout verticalAlignment: aBlElementAlignment

]
