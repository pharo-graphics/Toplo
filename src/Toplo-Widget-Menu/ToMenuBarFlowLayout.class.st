Class {
	#name : #ToMenuBarFlowLayout,
	#superclass : #ToBarFlowLayout,
	#instVars : [
		'menuBarOwner'
	],
	#category : #'Toplo-Widget-Menu-ItemBar'
}

{ #category : #layout }
ToMenuBarFlowLayout >> layout: anElement in: newBounds context: aBlElementBoundsUpdateContext [

	"(menuBarOwner notNil and: [
		 menuBarOwner isSubmenu and: [ menuBarOwner isInline ] ]) ifTrue: [
		minNodeWidth := menuBarOwner width ]."
	super
		layout: anElement
		in: newBounds
		context: aBlElementBoundsUpdateContext
]

{ #category : #accessing }
ToMenuBarFlowLayout >> menuBarOwner: aMenuBarOwner [

	menuBarOwner := aMenuBarOwner
]

{ #category : #initialization }
ToMenuBarFlowLayout >> newMeasurer [ 

	^ ToMenuBarFlowLayoutMeasurer for: self
]
