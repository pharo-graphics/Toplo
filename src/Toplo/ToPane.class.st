"
I'm a container with a Frame layout. (see `BlFrameLayout` comments)
"
Class {
	#name : #ToPane,
	#superclass : #ToElement,
	#traits : 'TToWidget',
	#classTraits : 'TToWidget classTrait',
	#category : #'Toplo-Widget-Pane'
}

{ #category : #'t - initialization' }
ToPane >> defaultLayout [

	^ BlFrameLayout new 
]

{ #category : #accessing }
ToPane >> horizontalAlignment [
	<return: #BlElementAlignment>

	^ self layout horizontalAlignment 
]

{ #category : #accessing }
ToPane >> horizontalAlignment: aBlElementAlignment [

	self horizontalAlignment = aBlElementAlignment ifTrue: [ ^self ].
	self layout horizontalAlignment: aBlElementAlignment.

]

{ #category : #accessing }
ToPane >> verticalAlignment [
	<return: #BlElementAlignment>

	^ self layout verticalAlignment 
]

{ #category : #accessing }
ToPane >> verticalAlignment: aBlElementAlignment [

	self verticalAlignment = aBlElementAlignment ifTrue: [ ^self ].
	self layout verticalAlignment: aBlElementAlignment

]
