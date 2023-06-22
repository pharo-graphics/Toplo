Class {
	#name : #ToMenuDresser,
	#superclass : #ToGeneralButtonDresser,
	#instVars : [
		'addedToParentHandler',
		'removedFromParentHandler',
		'menuParent',
		'menuParentOverEventHandler'
	],
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'api - install/uninstall  hook' }
ToMenuDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	
	addedToParentHandler := BlEventHandler on: BlElementAddedToParentEvent do: [ self whenAdded: anElement ].
	removedFromParentHandler := BlEventHandler on: BlElementRemovedFromParentEvent do: [ self whenRemoved: anElement ].
	anElement addEventHandler: addedToParentHandler.
	anElement addEventHandler: removedFromParentHandler.

	anElement constraintsDo: [ :c | 
		c horizontal fitContent.
		c vertical fitContent ]
]

{ #category : #'api - install/uninstall  hook' }
ToMenuDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement

]

{ #category : #'api - install/uninstall  hook' }
ToMenuDresser >> whenAdded: anElement [

	menuParent := anElement parent.
	menuParentOverEventHandler := BlEventHandler
		                              on: BlMouseOverEvent
		                              do: [ :event |
			                              anElement subMenuWindow ifNotNil: [
				                              :smw |
				                              ((event target hasParent: smw) or: [
					                               event target = smw or: [
						                               event target = anElement or: [
							                               event target hasParent:
								                               anElement ] ] ]) ifFalse: [
					                              smw close ] ] ].
	menuParent addEventHandler: menuParentOverEventHandler
]

{ #category : #'api - install/uninstall  hook' }
ToMenuDresser >> whenRemoved: anElement [

	menuParent removeEventHandler: menuParentOverEventHandler.
	menuParent := nil.
	menuParentOverEventHandler := nil
]
