Class {
	#name : #ToDivider,
	#superclass : #ToElement,
	#traits : 'TToOrientable',
	#classTraits : 'TToOrientable classTrait',
	#instVars : [
		'thickness'
	],
	#category : #'Toplo-Widget-Pane-Core'
}

{ #category : #configuration }
ToDivider >> applyConfiguration [ 

	super applyConfiguration.
	self isHorizontal
		ifTrue: [
				self hMatchParent.
				self constraints vertical exact: self thickness ]
		ifFalse: [
				self vMatchParent.
				self constraints horizontal exact: self thickness ].
	self requestNewSkin
]

{ #category : #initialization }
ToDivider >> defaultEventHandler [ 

	^ ToDividerEventHandler new
]

{ #category : #initialization }
ToDivider >> defaultLayout [

	^ BlLinearLayout new 
]

{ #category : #initialization }
ToDivider >> defaultThickness [

	^ 3
]

{ #category : #initialization }
ToDivider >> initialize [

	super initialize.
	self constraintsDo: [ :c | c ignoreByLayout ].
	self addEventHandler: self defaultEventHandler 
]

{ #category : #skin }
ToDivider >> newRawSkin [

	^ ToDividerSkin new
]

{ #category : #accessing }
ToDivider >> thickness [

	^ thickness ifNil: [ thickness := self defaultThickness ]
]

{ #category : #accessing }
ToDivider >> thickness: aNumber [

	thickness := aNumber.
	self requestConfiguration
]
