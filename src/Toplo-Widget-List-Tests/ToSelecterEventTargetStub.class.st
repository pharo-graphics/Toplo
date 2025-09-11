Class {
	#name : #ToSelecterEventTargetStub,
	#superclass : #BlElement,
	#traits : 'TToAuthorisationRequestTarget',
	#classTraits : 'TToAuthorisationRequestTarget classTrait',
	#instVars : [
		'selectionModel',
		'scrollIndex'
	],
	#category : #'Toplo-Widget-List-Tests-Selection-Selecter'
}

{ #category : #'private - commands' }
ToSelecterEventTargetStub >> addedDataSourceCommand: aCoomand [
]

{ #category : #accessing }
ToSelecterEventTargetStub >> itemCount [

	^ 100
]

{ #category : #'data source updates' }
ToSelecterEventTargetStub >> postponeAction: aValuable [ 

	aValuable cull: nil
]

{ #category : #accessing }
ToSelecterEventTargetStub >> scrollIndex [ 

	^ scrollIndex
]

{ #category : #'t - infinite accessing' }
ToSelecterEventTargetStub >> scrollTowardEndToDataSourcePosition: aPosition [

	scrollIndex := aPosition
]

{ #category : #'t - infinite accessing' }
ToSelecterEventTargetStub >> scrollTowardStartToDataSourcePosition: aPosition [

	scrollIndex := aPosition
]

{ #category : #accessing }
ToSelecterEventTargetStub >> selectionModel [ 

	^ selectionModel 
]

{ #category : #accessing }
ToSelecterEventTargetStub >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel
		                  on: self;
		                  yourself
]

{ #category : #'event firing' }
ToSelecterEventTargetStub >> updateAllSelections [
]
