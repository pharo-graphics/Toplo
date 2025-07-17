Class {
	#name : #ToTabBarElement,
	#superclass : #ToCheckableBarElement,
	#instVars : [
		'atStartSide'
	],
	#category : #'Toplo-Widget-TabPane-TabBar'
}

{ #category : #configuration }
ToTabBarElement >> applyWidgetConfiguration [

	super applyWidgetConfiguration.
	self nodesDo: [ :node |
		node item requestNewConfiguration.
		node requestNewSkin ].
	self requestLayout
]

{ #category : #accessing }
ToTabBarElement >> atStartSide [

	^ atStartSide
]

{ #category : #accessing }
ToTabBarElement >> atStartSide: aBoolean [

	atStartSide = aBoolean ifTrue: [ ^ self ].
	atStartSide := aBoolean.
	self requestNewConfiguration
]

{ #category : #'t - item list - accessing' }
ToTabBarElement >> defaultNodeManagerClass [

	^ ToTabNodeManager
]

{ #category : #initialization }
ToTabBarElement >> initialize [ 

	super initialize.
	atStartSide := true
]

{ #category : #testing }
ToTabBarElement >> isAtEndSide [ 

	^ self isAtStartSide not
]

{ #category : #testing }
ToTabBarElement >> isAtStartSide [

	^ atStartSide
]

{ #category : #skin }
ToTabBarElement >> newRawSkin [ 

	^ ToTabBarElementSkin new
]
