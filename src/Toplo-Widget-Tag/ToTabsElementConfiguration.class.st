Class {
	#name : #ToTabsElementConfiguration,
	#superclass : #ToTripletElementConfiguration,
	#instVars : [
		'atStartSide'
	],
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #hook }
ToTabsElementConfiguration >> applyOn: aTabsElement [

	super applyOn: aTabsElement.
	aTabsElement itemBar horizontal: aTabsElement isHorizontal.
	aTabsElement itemBar atStartSide: atStartSide.
	aTabsElement itemBar matchParent.
	
	aTabsElement isHFitContent
		ifTrue: [
			aTabsElement middleContainer constraintsDo: [ :c | c horizontal fitContent ].
			aTabsElement itemBar hFitContent ]
		ifFalse: [
			aTabsElement middleContainer constraintsDo: [ :c | c horizontal matchParent ].
			aTabsElement itemBar hMatchParent ].

	aTabsElement isVFitContent
		ifTrue: [
			aTabsElement middleContainer constraintsDo: [ :c | c vertical fitContent ].
			aTabsElement itemBar vFitContent ]
		ifFalse: [
			aTabsElement middleContainer constraintsDo: [ :c | c vertical matchParent ].
			aTabsElement itemBar vMatchParent ].

	aTabsElement isHorizontal
		ifTrue: [ aTabsElement endElement layout beHorizontal ]
		ifFalse: [ aTabsElement endElement layout beVertical ]
]

{ #category : #accessing }
ToTabsElementConfiguration >> atStartSide [

	^ atStartSide
]

{ #category : #accessing }
ToTabsElementConfiguration >> atStartSide: aBoolean [

	atStartSide := aBoolean
]

{ #category : #initialization }
ToTabsElementConfiguration >> initialize [ 

	super initialize.
	atStartSide := true.

]
