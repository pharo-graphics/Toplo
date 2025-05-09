Class {
	#name : #ToBarLinearLayout,
	#superclass : #BlLinearLayout,
	#traits : 'TToBarLayout',
	#classTraits : 'TToBarLayout classTrait',
	#instVars : [
		'maxMeasuredNodeSize'
	],
	#category : #'Toplo-Widget-List-InnerBar'
}

{ #category : #accessing }
ToBarLinearLayout >> maxMeasuredNodeSize [

	^ maxMeasuredNodeSize ifNil: [ maxMeasuredNodeSize := 0@0 ]
]

{ #category : #accessing }
ToBarLinearLayout >> maxMeasuredNodeSize: aSize [

	maxMeasuredNodeSize := aSize
]

{ #category : #measure }
ToBarLinearLayout >> newHorizontalMeasurer [ 

	^ ToBarLinearLayoutHorizontalMeasurer new 
]

{ #category : #measure }
ToBarLinearLayout >> newVerticalMeasurer [ 

	^ ToBarLinearLayoutVerticalMeasurer new 
]
