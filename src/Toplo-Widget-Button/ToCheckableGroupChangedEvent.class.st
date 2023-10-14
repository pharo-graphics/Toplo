Class {
	#name : 'ToCheckableGroupChangedEvent',
	#superclass : 'BlEvent',
	#instVars : [
		'checkedButtons',
		'uncheckedButtons'
	],
	#category : 'Toplo-Widget-Button-Checkable',
	#package : 'Toplo-Widget-Button',
	#tag : 'Checkable'
}

{ #category : 'accessing' }
ToCheckableGroupChangedEvent >> checkedButtons [

	^ checkedButtons
]

{ #category : 'accessing' }
ToCheckableGroupChangedEvent >> checkedButtons: anObject [

	checkedButtons := anObject
]

{ #category : 'accessing' }
ToCheckableGroupChangedEvent >> uncheckedButtons [

	^ uncheckedButtons
]

{ #category : 'accessing' }
ToCheckableGroupChangedEvent >> uncheckedButtons: anObject [

	uncheckedButtons := anObject
]
