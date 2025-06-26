"
I'm a dull domain object for examples.
"
Class {
	#name : #ToExIconDesc,
	#superclass : #Object,
	#instVars : [
		'provider',
		'style',
		'name'
	],
	#category : #'Toplo-Examples-Parts'
}

{ #category : #converting }
ToExIconDesc >> asString [

	^ style prefix, ' ', name
]

{ #category : #accessing }
ToExIconDesc >> icon [

	^ style iconNamed: name inProvider: provider
]

{ #category : #accessing }
ToExIconDesc >> name [

	^ name
]

{ #category : #accessing }
ToExIconDesc >> name: anObject [

	name := anObject
]

{ #category : #accessing }
ToExIconDesc >> provider [

	^ provider
]

{ #category : #accessing }
ToExIconDesc >> provider: anObject [

	provider := anObject
]

{ #category : #accessing }
ToExIconDesc >> style [

	^ style
]

{ #category : #accessing }
ToExIconDesc >> style: anObject [

	style := anObject
]
