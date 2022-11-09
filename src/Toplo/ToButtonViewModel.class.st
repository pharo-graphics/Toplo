Class {
	#name : #ToButtonViewModel,
	#superclass : #ToBasicButtonViewModel,
	#category : #'Toplo-Widget-Buttons'
}

{ #category : #accessing }
ToButtonViewModel >> iconImage: anElement [

	iconViewModel image: anElement
]

{ #category : #initialization }
ToButtonViewModel >> initialize [ 

	super initialize.
	self widgetPerformOrDefer: [ :widget | widget padding: (BlInsets all: 2)].
	self labelViewModel widgetPerformOrDefer: [ :widget | widget padding: (BlInsets all: 2) ].
	self iconViewModel widgetPerformOrDefer: [ :widget | widget padding: (BlInsets all: 2) ].
]

{ #category : #'api - hooks' }
ToButtonViewModel >> onInstalledOnlyMeIn: aToButton [

	super onInstalledOnlyMeIn: aToButton
]
