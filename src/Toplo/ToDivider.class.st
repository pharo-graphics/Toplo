Class {
	#name : #ToDivider,
	#superclass : #ToElement,
	#traits : 'TToWidget',
	#classTraits : 'TToWidget classTrait',
	#instVars : [
		'thickness',
		'horizontal',
		'first',
		'second'
	],
	#category : #'Toplo-Widget-Pane'
}

{ #category : #factory }
ToDivider class >> horizontal [

	^ self basicNew beHorizontal; initialize
]

{ #category : #'instance creation' }
ToDivider class >> new [

	^ self error: 'Use #horizontal or #vertical class methods'
]

{ #category : #factory }
ToDivider class >> vertical [

	^ self basicNew beVertical; initialize
]

{ #category : #accessing }
ToDivider >> beHorizontal [

	horizontal := true
]

{ #category : #accessing }
ToDivider >> beVertical [ 

	horizontal := false
]

{ #category : #'t - initialization dresser' }
ToDivider >> defaultDresser [

	^ ToDividerDresser new
]

{ #category : #'t - initialization' }
ToDivider >> defaultLayout [

	^ BlBasicLayout new 
]

{ #category : #accessing }
ToDivider >> first [

	^ first
]

{ #category : #accessing }
ToDivider >> first: anObject [

	first := anObject
]

{ #category : #initialization }
ToDivider >> initialize [

	super initialize.
	self initializeDresser 
]

{ #category : #testing }
ToDivider >> isHorizontal [

	^ horizontal
]

{ #category : #testing }
ToDivider >> isVertical [

	^ self isHorizontal not
]

{ #category : #accessing }
ToDivider >> second [

	^ second
]

{ #category : #accessing }
ToDivider >> second: anObject [

	second := anObject
]

{ #category : #accessing }
ToDivider >> thickness [

	^ thickness
]

{ #category : #accessing }
ToDivider >> thickness: aNumber [

	thickness := aNumber
]
