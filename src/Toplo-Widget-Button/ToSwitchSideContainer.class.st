Class {
	#name : #ToSwitchSideContainer,
	#superclass : #ToElement,
	#instVars : [
		'parentSwitchIcon'
	],
	#category : #'Toplo-Widget-Button-Switch'
}

{ #category : #'hooks - children' }
ToSwitchSideContainer >> onChildAdded: anElement [

	super onChildAdded: anElement.
	self parentSwitchIcon onChildAddedInSideContainer
]

{ #category : #accessing }
ToSwitchSideContainer >> parentSwitchIcon [

	^ parentSwitchIcon
]

{ #category : #accessing }
ToSwitchSideContainer >> parentSwitchIcon: aSwitchIcon [

	parentSwitchIcon := aSwitchIcon
]
