Class {
	#name : #ToIconDescExample,
	#superclass : #Object,
	#instVars : [
		'provider',
		'style',
		'name'
	],
	#category : #'Toplo-Examples'
}

{ #category : #accessing }
ToIconDescExample >> icon [

	^ style iconNamed: name inProvider: provider
]

{ #category : #accessing }
ToIconDescExample >> name [

	^ name
]

{ #category : #accessing }
ToIconDescExample >> name: anObject [

	name := anObject
]

{ #category : #accessing }
ToIconDescExample >> provider [

	^ provider
]

{ #category : #accessing }
ToIconDescExample >> provider: anObject [

	provider := anObject
]

{ #category : #accessing }
ToIconDescExample >> style [

	^ style
]

{ #category : #accessing }
ToIconDescExample >> style: anObject [

	style := anObject
]
