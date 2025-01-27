"
I'm a menu item with toggle behavior. 
I'm one of the leave of menu composite.
"
Class {
	#name : #ToSegmentedToggleButton,
	#superclass : #ToElement,
	#traits : 'TToOrientable + TToTripletElement + TToLabeledIcon + TToItem + TToClickable + TToCheckable',
	#classTraits : 'TToOrientable classTrait + TToTripletElement classTrait + TToLabeledIcon classTrait + TToItem classTrait + TToClickable classTrait + TToCheckable classTrait',
	#instVars : [
		'optCheckableData',
		'tripletProperties'
	],
	#category : #'Toplo-Widget-Segmented-Button'
}

{ #category : #'t - checkable - accessing' }
ToSegmentedToggleButton >> checkableData [

	^ optCheckableData 
]

{ #category : #'t - checkable - accessing' }
ToSegmentedToggleButton >> checkableData: aCheckableData [

	optCheckableData := aCheckableData
]

{ #category : #initialization }
ToSegmentedToggleButton >> defaultLayout [ 

	^ BlLinearLayout horizontal
]

{ #category : #initialization }
ToSegmentedToggleButton >> initialize [

	super initialize.
	self addEventHandler: ToClickableFocusEventHandler new.
	self initializeAsTripletElement.
	self initializeAsCheckable.
	self clickEventClass: ToCheckableCheckEvent
]

{ #category : #'t - orientable - accessing' }
ToSegmentedToggleButton >> layoutStrategy [

	^ self layout

	
]

{ #category : #skin }
ToSegmentedToggleButton >> newRawSkin [ 

	^ ToSegmentedToggleButtonSkin new
]

{ #category : #'adding-removing' }
ToSegmentedToggleButton >> onAddedInItemBarOwner: aSegmentedElement [

	aSegmentedElement onAddedSegmentedButton: self
	
]

{ #category : #layout }
ToSegmentedToggleButton >> onLayout: aBounds context: aBlElementBoundsUpdateContext [

	self configureLayout.
	super onLayout: aBounds context: aBlElementBoundsUpdateContext
]

{ #category : #'adding-removing' }
ToSegmentedToggleButton >> onRemovedFromItemBarOwner: aSegmentedElement [

	aSegmentedElement onRemovedSegmentedButton: self
	
]

{ #category : #'t - triplet element - private - accessing' }
ToSegmentedToggleButton >> tripletProperties [

	^ tripletProperties
]

{ #category : #'t - triplet element - private - accessing' }
ToSegmentedToggleButton >> tripletProperties: aTripletElementProperties [

	tripletProperties := aTripletElementProperties
]
