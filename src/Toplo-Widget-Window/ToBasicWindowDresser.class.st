Class {
	#name : #ToBasicWindowDresser,
	#superclass : #ToDresser,
	#instVars : [
		'widgetRemovedHandler',
		'widgetRemovedFromSpaceHandler'
	],
	#category : #'Toplo-Widget-Window'
}

{ #category : #'api - install/uninstall  hook' }
ToBasicWindowDresser >> installWidget: newWidget in: anElement [

	widgetRemovedHandler := BlEventHandler
		                        on: BlElementRemovedFromParentEvent
		                        do: [ anElement close ].
	widgetRemovedFromSpaceHandler := BlEventHandler
		                                 on:
		                                 BlElementRemovedFromSceneGraphEvent
		                                 do: [ anElement close ].

	newWidget addEventHandler: widgetRemovedHandler.
	newWidget addEventHandler: widgetRemovedFromSpaceHandler
]

{ #category : #'api - install/uninstall  hook' }
ToBasicWindowDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement whenWidgetChangedDo: [ :newWidget :oldWidget | 
		self uninstallWidget: oldWidget in: anElement.
		self installWidget: newWidget in: anElement. ].
	

]

{ #category : #'api - install/uninstall  hook' }
ToBasicWindowDresser >> uninstallWidget: oldWidget in: anElement [

	oldWidget ifNil: [ ^ self ].
	oldWidget removeEventHandler: widgetRemovedHandler.
	oldWidget removeEventHandler: widgetRemovedFromSpaceHandler
]
