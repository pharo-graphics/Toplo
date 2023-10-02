Class {
	#name : #ToButton,
	#superclass : #ToGeneralButton,
	#traits : 'TToOrientable',
	#classTraits : 'TToOrientable classTrait',
	#instVars : [
		'#labeledIcon => ToSkinnableSlot'
	],
	#category : #'Toplo-Widget-Button-BasicButton'
}

{ #category : #initialization }
ToButton >> defaultLayout [ 

	^ BlLinearLayout vertical
]

{ #category : #'t - skinable - initialization' }
ToButton >> defaultStyleStamps [

	^ { #button }
]

{ #category : #accessing }
ToButton >> icon [

	^ self labeledIcon icon
]

{ #category : #accessing }
ToButton >> icon: aToImage [

	self labeledIcon icon: aToImage
]

{ #category : #initialization }
ToButton >> initialize [

	super initialize.
	self withStamp: #button.
	self layout: self defaultLayout.
	labeledIcon := ToLabeledIcon new.
	self addChild: labeledIcon.
	self fitContent
]

{ #category : #accessing }
ToButton >> label [

	^ self labeledIcon label
]

{ #category : #accessing }
ToButton >> label: aToLabel [

	self labeledIcon label: aToLabel
]

{ #category : #accessing }
ToButton >> labeledIcon [

	^ labeledIcon
]

{ #category : #'t - orientable - accessing' }
ToButton >> layoutStrategy [

	^ self innerElement layout

	
]
