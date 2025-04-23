Class {
	#name : #ToTabItemElement,
	#superclass : #ToItemToggleButton,
	#traits : 'TToShrinkable + TToRemovableItem',
	#classTraits : 'TToShrinkable classTrait + TToRemovableItem classTrait',
	#instVars : [
		'removable'
	],
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #configuration }
ToTabItemElement >> applyWidgetConfiguration [

	| listElement |
	super applyWidgetConfiguration.
	listElement := self holder listElement.
	(listElement isVertical and: [ listElement atStartSide not ])
		ifTrue: [
			self startFlexible: true.
			self endFlexible: false ]
		ifFalse: [
			self startFlexible: false.
			self endFlexible: true ]
]

{ #category : #initialization }
ToTabItemElement >> initialize [

	super initialize.
	self applySkinInstallerOnFirstRequest: true
]

{ #category : #'t - triplet element - accessing' }
ToTabItemElement >> middleElement: anElement [

	super middleElement: anElement.
	"anElement addShrinkFeedbackLayerWithReferenceParent: self "
]

{ #category : #skin }
ToTabItemElement >> newRawSkin [ 

	^ ToTabItemElementSkin new
]
