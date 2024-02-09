Class {
	#name : #ToSelectReadOnlyMode,
	#superclass : #ToSelectMode,
	#instVars : [
		'listSelectionChangedEventHandler'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #accessing }
ToSelectReadOnlyMode >> data [

	^ select listElement data
]

{ #category : #'accessing selection' }
ToSelectReadOnlyMode >> deselectIndex: anIndex [

	select listElement selecter deselectIndex: anIndex.
	select selection deselectIndex: anIndex
]

{ #category : #'accessing selection' }
ToSelectReadOnlyMode >> onClickAtIndex: anIndex [

	(select listElement selectionModel containsIndex: anIndex)
		ifTrue: [ self deselectIndex: anIndex ]
		ifFalse: [ self selectIndex: anIndex ]
]

{ #category : #'api - hooks' }
ToSelectReadOnlyMode >> onInstalledIn: aSelect [

	super onInstalledIn: aSelect.
	
	listSelectionChangedEventHandler := BlEventHandler
			 on: ToListSelectionChangedEvent
			 do: [ :event | select strategy refreshHeaderNodeContainer ].
	select listElement addEventHandler: listSelectionChangedEventHandler
]

{ #category : #'api - hooks' }
ToSelectReadOnlyMode >> onUninstalledIn: aSelect [

	select listElement removeEventHandler: listSelectionChangedEventHandler.
	listSelectionChangedEventHandler := nil.
	select selectionModel: nil.
	super onUninstalledIn: aSelect.

]

{ #category : #'accessing selection' }
ToSelectReadOnlyMode >> selectIndex: anIndex [

	select isMultipleSelection ifFalse: [
		select listElement selecter deselectAll.
		select selection deselectAll ].
	select listElement selecter selectIndex: anIndex.
	select selection selectIndex: anIndex
]
