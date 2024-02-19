Class {
	#name : #ToChoiceMenuDataEventHandler,
	#superclass : #ToObservableCollectionEventHandler,
	#instVars : [
		'choiceMenu'
	],
	#category : #'Toplo-Widget-Menu-Choice menu'
}

{ #category : #accessing }
ToChoiceMenuDataEventHandler >> choiceMenu: aChoiceMenu [

	choiceMenu := aChoiceMenu
]

{ #category : #'data events handling' }
ToChoiceMenuDataEventHandler >> collectionAddEvent: anEvent [

	| newItems |
	anEvent interval ifEmpty: [ ^ self ].
	newItems := anEvent interval collect: [ :idx |
		            choiceMenu newMenuItemFromData:
			            (anEvent currentTarget at: idx) ].
	choiceMenu addAllItems: newItems.
	choiceMenu group addAll: newItems
]

{ #category : #'data events handling' }
ToChoiceMenuDataEventHandler >> collectionRemoveRequest: aRequest [

	| removedData col |
	col := aRequest currentTarget.
	aRequest interval ifEmpty: [ ^ self ].
	removedData := aRequest interval collect: [ :idx | col at: idx ].
	removedData do: [ :d |
		| item |
		item := choiceMenu menuItemFromData: d.
		item isChecked ifTrue: [ item checked: false ].
		item isChecked ifTrue: [
			aRequest accepted: false.
			^ Error signal: 'Can''t removed a checked item' ] ].
	removedData do: [ :d |
		| item |
		item := choiceMenu menuItemFromData: d.
		choiceMenu removeItem: item.
		choiceMenu group remove: item ]
]

{ #category : #'data events handling' }
ToChoiceMenuDataEventHandler >> collectionUpdateEvent: anEvent [

	| col |
	col := anEvent currentTarget.
	anEvent interval ifEmpty: [ ^ self ].
	anEvent interval  do: [ :idx |
		| prevItem newItem |
		prevItem := col at: idx.
		newItem := choiceMenu newMenuItemFromData: prevItem.
		self flag: 'ToDo'.
		choiceMenu replaceItemAt: idx with: newItem.
		choiceMenu group replace: prevItem with: newItem.
		(choiceMenu selectedData = (col at: idx)) ifTrue: [ self selectData: nil ] ]
]
