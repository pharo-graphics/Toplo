Class {
	#name : #ToMenuNode,
	#superclass : #ToBarNode,
	#instVars : [
		'menuItem',
		'enablementChangedHandler'
	],
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'friend only' }
ToMenuNode >> addEnablementHandler [

	menuItem ifNil: [ ^ self ].
	enablementChangedHandler := menuItem
		                            addEventHandlerOn:
		                            ToEnablementChangedEvent
		                            do: [
		                            self disabled: menuItem isDisabled ]
]

{ #category : #'t - bar node' }
ToMenuNode >> autoDistribute: aBoolean [

	super autoDistribute: aBoolean.
	aBoolean ifTrue: [
		self item constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ] ]
]

{ #category : #'t - bar node' }
ToMenuNode >> item [

	^ self firstChild
]

{ #category : #'t - bar node' }
ToMenuNode >> item: aMenuItem [

	menuItem ifNotNil: [
		menuItem removeFromParent.
		menuItem := nil ].
	aMenuItem ifNil: [ ^ self ].
	aMenuItem removeFromParent.
	self addChild: aMenuItem.
	menuItem := aMenuItem
]

{ #category : #skin }
ToMenuNode >> newRawSkin [ 

	^ ToMenuNodeSkin new
]

{ #category : #'friend only' }
ToMenuNode >> removeEnablementHandler [

	enablementChangedHandler ifNil: [ ^ self ].
	menuItem removeEventHandler: enablementChangedHandler.
	enablementChangedHandler := nil
]
