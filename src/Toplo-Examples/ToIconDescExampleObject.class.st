"
I'm a dull domain object for examples.
"
Class {
	#name : #ToIconDescExampleObject,
	#superclass : #Object,
	#instVars : [
		'provider',
		'style',
		'name'
	],
	#category : #'Toplo-Examples-Parts'
}

{ #category : #converting }
ToIconDescExampleObject >> asString [

	^ style prefix, ' ', name
]

{ #category : #accessing }
ToIconDescExampleObject >> icon [

	^ style iconNamed: name inProvider: provider
]

{ #category : #accessing }
ToIconDescExampleObject >> name [

	^ name
]

{ #category : #accessing }
ToIconDescExampleObject >> name: anObject [

	name := anObject
]

{ #category : #accessing }
ToIconDescExampleObject >> provider [

	^ provider
]

{ #category : #accessing }
ToIconDescExampleObject >> provider: anObject [

	provider := anObject
]

{ #category : #accessing }
ToIconDescExampleObject >> style [

	^ style
]

{ #category : #accessing }
ToIconDescExampleObject >> style: anObject [

	style := anObject
]
