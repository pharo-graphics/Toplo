Class {
	#name : #ToBarLinearLayoutHorizontalMeasurer,
	#superclass : #BlLinearLayoutHorizontalMeasurer,
	#traits : 'TToBarMeasurer',
	#classTraits : 'TToBarMeasurer classTrait',
	#category : #'Toplo-Widget-List-InnerBar'
}

{ #category : #'t - bar measurer' }
ToBarLinearLayoutHorizontalMeasurer >> barNodes [

	^ nodes
]

{ #category : #'t - bar measurer' }
ToBarLinearLayoutHorizontalMeasurer >> preMeasure [
	"See how wide/tall everyone is. Also remember max breadth."

	super preMeasure.
	self shouldCheckUniformSize ifFalse: [ ^ self ].
	self barUniformMeasure 
]
