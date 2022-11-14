Class {
	#name : #ToMultiStateButtonModel,
	#superclass : #ToButtonModel,
	#instVars : [
		'stateEngine'
	],
	#category : #'Toplo-Widget-Buttons'
}

{ #category : #'mouse handlers' }
ToMultiStateButtonModel >> clickEvent: anEvent [

	stateEngine stepOn: anEvent currentTarget
]

{ #category : #initialization }
ToMultiStateButtonModel >> initialize [

	super initialize.
	stateEngine := ToStateButtonEngine new
]

{ #category : #'api - hooks' }
ToMultiStateButtonModel >> onInstalledOnlyMeIn: aToButton [

	super onInstalledOnlyMeIn: aToButton.
	stateEngine startOn: aToButton 	
]

{ #category : #'private - accessing - widget' }
ToMultiStateButtonModel >> privateWidgetClass [

	^ ToButton
]

{ #category : #'state - accessing' }
ToMultiStateButtonModel >> states: aCollectionOfStates transitions: aCollection [

	stateEngine states: aCollectionOfStates transitions: (aCollection collect: #asToButtonTransition)
]
