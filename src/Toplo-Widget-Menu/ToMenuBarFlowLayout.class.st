Class {
	#name : #ToMenuBarFlowLayout,
	#superclass : #ToBarFlowLayout,
	#instVars : [
		'menuBarOwner'
	],
	#category : #'Toplo-Widget-Menu-ItemBar'
}

{ #category : #layout }
ToMenuBarFlowLayout >> checkMinNodeWidth [

	(menuBarOwner notNil and: [ menuBarOwner isInline ]) ifTrue: [
		self minNodeWidth: menuBarOwner measuredWidth ]
]

{ #category : #measure }
ToMenuBarFlowLayout >> measure: anElement with: anExtentSpec [

	self checkMinNodeWidth.
	super measure: anElement with: anExtentSpec
]

{ #category : #accessing }
ToMenuBarFlowLayout >> menuBarOwner: aMenuBarOwner [

	menuBarOwner := aMenuBarOwner
]

{ #category : #initialization }
ToMenuBarFlowLayout >> newMeasurer [ 

	^ ToMenuBarFlowLayoutMeasurer for: self
]
