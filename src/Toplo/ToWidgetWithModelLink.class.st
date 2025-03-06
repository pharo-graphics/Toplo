Class {
	#name : #ToWidgetWithModelLink,
	#superclass : #Object,
	#traits : 'TBlEventTarget',
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'property',
		'eventDispatcher'
	],
	#category : #'Toplo-Core-Properties'
}

{ #category : #initialization }
ToWidgetWithModelLink >> configureToUpdateModel: aModel fromWidget: aWidget [

	self subclassResponsibility 
]

{ #category : #initialization }
ToWidgetWithModelLink >> configureToUpdateWidget: aWidget fromModel: aModel [

	self subclassResponsibility 
]

{ #category : #'event management accessing' }
ToWidgetWithModelLink >> eventDispatcher [
	"Return an object responsible for event dispatching"

	<return: #BlDirectEventDispatcher>
	^ eventDispatcher ifNil: [
		  eventDispatcher := BlDirectEventDispatcher on: self ]
]

{ #category : #initialization }
ToWidgetWithModelLink >> linkWidget: aWidget withModel: aModel [

	aWidget linkProperty
		ifNil: [
			aWidget linkFeatureName ifNotNil: [ :lf |
				property := ToFeatureProperty new name: lf.
				aWidget linkFeatureWriterName ifNotNil: [ :wn |
					property writerName: wn ] ] ]
		ifNotNil: [ :lp | property := lp ].

	self configureToUpdateWidget: aWidget fromModel: aModel.
	self configureToUpdateModel: aModel fromWidget: aWidget
]

{ #category : #'reading-writing' }
ToWidgetWithModelLink >> onModelValueChangedDo: aValuable [

	self
		addEventHandlerOn: ToModelChangedEvent
		do: [ :evt | aValuable value: (self read: evt model) ]
]

{ #category : #'reading-writing' }
ToWidgetWithModelLink >> read: aModel [

	^ property read: aModel
]

{ #category : #'reading-writing' }
ToWidgetWithModelLink >> write: aValue to: aModel [

	property write: aValue to: aModel.
	self dispatchEvent: (ToModelChangedEvent new
			 model: aModel;
			 writtenValue: aValue;
			 yourself)
]
