Class {
	#name : #ToListAdditionalSelectionMode,
	#superclass : #ToAbstractListSelectionMode,
	#instVars : [
		'ownsSelecter'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'instance creation' }
ToListAdditionalSelectionMode class >> selecter: aSelecter elementBuilder: aSelectionElementBuilderValuable [

	^ self new
		  in: [ :mode |
			  mode listEventHandler:
					  (ToListBasicAdditionalSelectionElementEventHandler
						   selectionMode: mode
						   selectionChangedEventClass: aSelecter selectionChangedEventClass) ];
		  selecter: aSelecter;
		  elementBuilder: aSelectionElementBuilderValuable;
		  yourself
]

{ #category : #'instance creation' }
ToListAdditionalSelectionMode class >> selecter: aSelecter listEventHandler: aListEventHandler elementBuilder: aSelectionElementBuilderValuable [

	^ self new
		  in: [ :mode |
			  mode listEventHandler: (aListEventHandler
						   selectionMode: mode;
						   yourself) ];
		  selecter: aSelecter;
		  elementBuilder: aSelectionElementBuilderValuable;
		  yourself
]

{ #category : #'api - hooks' }
ToListAdditionalSelectionMode >> installDefaultOptionsIn: anElement [

	overOption := (ToListSelectionOption groupedForMode: self)
		                 beneath: false;
		                 yourself.
	beneathOption := (ToListSelectionOption noneForMode: self)
		              beneath: true;
		              yourself.
	beneathOption onInstalledIn: anElement.
	overOption onInstalledIn: anElement.


]

{ #category : #'api - hooks' }
ToListAdditionalSelectionMode >> installSelecterIn: anElement [

	ownsSelecter := selecter parentSelecter subSelecterIndex
		                includesKey: selecter uniqueId.
	ownsSelecter ifFalse: [ super installSelecterIn: anElement ]
]

{ #category : #testing }
ToListAdditionalSelectionMode >> isMultipleSelection [

	^ true
]

{ #category : #'api - hooks' }
ToListAdditionalSelectionMode >> uninstallSelecterIn: anElement [

	ownsSelecter ifFalse: [ super uninstallSelecterIn: anElement ]
]
