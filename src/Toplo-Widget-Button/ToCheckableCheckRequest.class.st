Class {
	#name : 'ToCheckableCheckRequest',
	#superclass : 'BlEvent',
	#instVars : [
		'checked'
	],
	#category : 'Toplo-Widget-Button-Checkable',
	#package : 'Toplo-Widget-Button',
	#tag : 'Checkable'
}

{ #category : 'accessing' }
ToCheckableCheckRequest >> checked [

	^ checked
]

{ #category : 'accessing' }
ToCheckableCheckRequest >> checked: aBoolean [

	checked := aBoolean
]
