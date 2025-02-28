Class {
	#name : #ToBarLinearLayoutVerticalMeasurer,
	#superclass : #BlLinearLayoutVerticalMeasurer,
	#traits : 'TToBarMeasurer',
	#classTraits : 'TToBarMeasurer classTrait',
	#category : #'Toplo-Widget-List-InnerBar'
}

{ #category : #'t - bar measurer' }
ToBarLinearLayoutVerticalMeasurer >> barNodes [

	^ nodes
]

{ #category : #measurement }
ToBarLinearLayoutVerticalMeasurer >> preMeasure [
	"See how wide/tall everyone is. Also remember max breadth."

	super preMeasure.
	self shouldCheckUniformSize ifFalse: [ ^ self ].
	self barUniformMeasure 
]
