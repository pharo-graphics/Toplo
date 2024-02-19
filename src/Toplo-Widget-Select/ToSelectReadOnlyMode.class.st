Class {
	#name : #ToSelectReadOnlyMode,
	#superclass : #ToSelectMode,
	#instVars : [
		'listSelectionChangedEventHandler'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #'api - hooks' }
ToSelectReadOnlyMode >> onInstalledIn: aSelect [

	super onInstalledIn: aSelect.
	
	"listSelectionChangedEventHandler := BlEventHandler
			 on: ToListSelectionChangedEvent
			 do: [ :event | select strategy refreshHeaderNodeContainer ].
	select listElement addEventHandler: listSelectionChangedEventHandler"
]

{ #category : #'api - hooks' }
ToSelectReadOnlyMode >> onUninstalledIn: aSelect [

	select listElement removeEventHandler: listSelectionChangedEventHandler.
	listSelectionChangedEventHandler := nil.
	select selectionModel: nil.
	super onUninstalledIn: aSelect.

]
