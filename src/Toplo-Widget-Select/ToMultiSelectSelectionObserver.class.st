Class {
	#name : #ToMultiSelectSelectionObserver,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'selectElement'
	],
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #'event handling' }
ToMultiSelectSelectionObserver >> addIndexesSelectionCommand: aCommand [
'addIndexesSelectionCommand:' traceCr
	"aCommand operation deselectAllBefore ifTrue: [
		selectElement nodeContainer dataAccessor removeAll ].
	selectElement nodeContainer dataAccessor addAll: (commandTarget data at: aCommand indexes last)"
]

{ #category : #'event handling' }
ToMultiSelectSelectionObserver >> addIntervalSelectionCommand: aCommand [

	|  holder dataItemView |
	aCommand operation deselectAllBefore ifTrue: [
		selectElement dataAccessor removeAll ].
	holder := selectElement listElement findElementHolderForDataSourcePosition: aCommand to.
	dataItemView := selectElement dataItemViewFactory value.
	dataItemView onInstalledIn: selectElement innerContainer.
	selectElement dataItemViewBuilder cull: dataItemView cull: holder cull: holder dataItem.
	selectElement innerContainer barElement dataAccessor add: dataItemView
]

{ #category : #'event handling' }
ToMultiSelectSelectionObserver >> addWholeSelectionCommand: aCommand [

	"(selectElement dataAccessor includes: commandTarget dataAccessor last)
		ifTrue: [ ^ self ].
	selectElement dataAccessor add: commandTarget dataAccessor last"
]

{ #category : #'api - accessing' }
ToMultiSelectSelectionObserver >> eventsToHandle [

	^ { ToPrimarySelectionCommandAppliedEvent }
]

{ #category : #'event handling' }
ToMultiSelectSelectionObserver >> primarySelectionCommandAppliedEvent: aCommandAppliedEvent [

	aCommandAppliedEvent  traceCr.
	aCommandAppliedEvent command applyOn: self in: selectElement
]

{ #category : #'event handling' }
ToMultiSelectSelectionObserver >> removeIndexesSelectionCommand: aCommand [


]

{ #category : #'event handling' }
ToMultiSelectSelectionObserver >> removeIntervalSelectionCommand: aCommand [

	"(selectElement dataAccessor includes:
		 (commandTarget dataAccessor at: aCommand to)) ifFalse: [ ^ self ].
	selectElement dataAccessor remove:
		(commandTarget dataAccessor at: aCommand to)"
]

{ #category : #'event handling' }
ToMultiSelectSelectionObserver >> removeWholeSelectionCommand: aCommand [

	selectElement innerContainer dataAccessor removeAll
]

{ #category : #accessing }
ToMultiSelectSelectionObserver >> selectElement: aSelectElement [

	selectElement := aSelectElement
]