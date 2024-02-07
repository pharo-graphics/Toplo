"
I am an event target for a ToSelectionModelOperator.
I used to build an autonomous selection model selecter to operate on a ToSelectionModel.

Just an example for now:

	| updater selecter selectionModel |
	selectionModel := ToSelectionModel new itemCountGetter: [ 100 ].
	updater := ToSelectionModelUpdater new.
	updater selectionModel: selectionModel.
	selecter := ToSelectionModelOperator new.
	selecter selectAll.
	selecter deselectIndex: 10.
	selecter applyOn: updater.
	updater

or :
	| selecter updater selectionModel |
	selectionModel := ToSelectionModel new itemCountGetter: [ 100 ].
	updater := selectionModel newUpdater.
	selecter := selectionModel newSelecter.
	selecter selectAll.
	selecter deselectIndex: 10.
	selecter applyOn: updater.
	updater

	
	
"
Class {
	#name : #ToSelectionModelUpdater,
	#superclass : #Object,
	#traits : 'TBlEventTarget',
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'eventDispatcher',
		'selectionModel'
	],
	#category : #'Toplo-Widget-List-Selection-Updater'
}

{ #category : #'event management accessing' }
ToSelectionModelUpdater >> eventDispatcher [
	"Return an object responsible for event dispatching"
	<return: #BlDirectEventDispatcher>

	^ eventDispatcher 
]

{ #category : #initialization }
ToSelectionModelUpdater >> initialize [

	super initialize.
	eventDispatcher := BlDirectEventDispatcher on: self.
	self addEventHandler: ToSelectionRequestEventHandler new
]

{ #category : #accessing }
ToSelectionModelUpdater >> selectionModel [

	^ selectionModel
]

{ #category : #accessing }
ToSelectionModelUpdater >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel
]
