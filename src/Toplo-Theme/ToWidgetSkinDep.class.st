Class {
	#name : 'ToWidgetSkinDep',
	#superclass : 'BlCustomEventHandler',
	#instVars : [
		'installStep',
		'firstLookUpdater',
		'subscriptions'
	],
	#category : 'Toplo-Theme-Skin-dep',
	#package : 'Toplo-Theme',
	#tag : 'Skin-dep'
}

{ #category : 'adding' }
ToWidgetSkinDep >> addAllLookUpdaters: aCollectionOfLook [

	aCollectionOfLook do: [ :l | self addLookUpdater: l ]
]

{ #category : 'accessing' }
ToWidgetSkinDep >> addAllSubscriptions: aSubscriptionCollection [

	subscriptions := subscriptions copyWithAll: aSubscriptionCollection
]

{ #category : 'adding' }
ToWidgetSkinDep >> addLookUpdater: aLook [

	aLook isNull ifTrue: [ ^ self ].
	aLook next: firstLookUpdater.
	self privateLookUpdater: aLook
]

{ #category : 'accessing' }
ToWidgetSkinDep >> addSubscription: aSubscription [

	subscriptions := subscriptions copyWith: aSubscription
]

{ #category : 'api - install/uninstall  hook' }
ToWidgetSkinDep >> defaultCursorLookIn: anElement [

	^ ToLookUpdaterDep new 
]

{ #category : 'accessing' }
ToWidgetSkinDep >> dispatchChangedEventIn: anElement [

	self markAsNotInstalled.
	anElement dispatchSkinChangedEvent
]

{ #category : 'event handling' }
ToWidgetSkinDep >> elementLookEvent: anEvent [

	anEvent sendTo: self firstLookUpdater.
	self subscriptions do: [ :s | s elementLookEvent: anEvent  ]
]

{ #category : 'api - accessing' }
ToWidgetSkinDep >> eventsToHandle [

	^ {
		  ToThemeChangedEvent.
		  ToSkinChangedEvent.
		  ToPropertyChangedEvent.
		  ToElementLookEvent.
		  ToLayoutOrientationChangedEvent.
		  ToLayoutDirectionChangedEvent }
]

{ #category : 'accessing' }
ToWidgetSkinDep >> firstLookUpdater [

	^ firstLookUpdater
]

{ #category : 'accessing' }
ToWidgetSkinDep >> forceInstallationIn: anElement [

	self markAsNotInstalled.
	anElement dispatchSkinChangedEvent
]

{ #category : 'initialization' }
ToWidgetSkinDep >> initialize [

	super initialize.
	self markAsNotInstalled.
	subscriptions := #().
	self privateLookUpdater: ToNullElementLook new
]

{ #category : 'api - install/uninstall  hook' }
ToWidgetSkinDep >> initializedLevel [

	^ 2

]

{ #category : 'api - install/uninstall  hook' }
ToWidgetSkinDep >> installedLevel [

	^ 1
]

{ #category : 'api - install/uninstall  hook' }
ToWidgetSkinDep >> isInitialized [

	^ installStep >= self initializedLevel 
]

{ #category : 'api - install/uninstall  hook' }
ToWidgetSkinDep >> isInstalled [

	^ installStep >= self installedLevel 
]

{ #category : 'api - install/uninstall  hook' }
ToWidgetSkinDep >> launchSkinInitializationIn: anElement [

	self isInitialized ifTrue: [ ^ self ].
	self markAsInitialized.
	anElement isDisabled ifTrue: [ ^ anElement switchToSkinState: ToDisabledState new ].
	anElement switchToSkinState: ToInitialState new
]

{ #category : 'api - install/uninstall  hook' }
ToWidgetSkinDep >> launchSkinInstallationIn: anElement [

	self isInitialized ifTrue: [ ^ self ].
	self isInstalled ifTrue: [ ^ self launchSkinInitializationIn: anElement ].
	self markAsInstalled.
	self onSkinInstalledIn: anElement.
	anElement switchToSkinState: ToInstallState new.
	self launchSkinInitializationIn: anElement.

]

{ #category : 'api - install/uninstall  hook' }
ToWidgetSkinDep >> launchSkinUninstallationIn: anElement [

	self isInstalled ifFalse: [ ^ self ].
	anElement dispatchLookEvent: ToUninstallLookEvent new.
	self onSkinUninstalledIn: anElement.
	self privateLookUpdater: ToNullElementLook new.
	self markAsNotInstalled 
]

{ #category : 'event handling' }
ToWidgetSkinDep >> layoutDirectionChangedEvent: anEvent [
]

{ #category : 'event handling' }
ToWidgetSkinDep >> layoutOrientationChangedEvent: anEvent [
]

{ #category : 'api - install/uninstall  hook' }
ToWidgetSkinDep >> markAsInitialized [

	installStep := self initializedLevel

]

{ #category : 'api - install/uninstall  hook' }
ToWidgetSkinDep >> markAsInstalled [

	installStep := self installedLevel 
]

{ #category : 'api - install/uninstall  hook' }
ToWidgetSkinDep >> markAsNotInstalled [

	installStep := 0
]

{ #category : 'api - install/uninstall  hook' }
ToWidgetSkinDep >> onSkinInstalledIn: anElement [

]

{ #category : 'api - install/uninstall  hook' }
ToWidgetSkinDep >> onSkinUninstalledIn: anElement [

	firstLookUpdater := nil
]

{ #category : 'private - accessing' }
ToWidgetSkinDep >> privateLookUpdater: aLook [

	firstLookUpdater := aLook
]

{ #category : 'event handling' }
ToWidgetSkinDep >> propertyChangedEvent: anEvent [

]

{ #category : 'accessing' }
ToWidgetSkinDep >> removeAllSubscriptions: aSubscriptionCollection [

	subscriptions := subscriptions copyWithoutAll: aSubscriptionCollection
]

{ #category : 'removing' }
ToWidgetSkinDep >> removeLookUpdater: aLook [

	firstLookUpdater = aLook 
		ifTrue: [ firstLookUpdater := firstLookUpdater next ]
		ifFalse: [ firstLookUpdater removeLook: aLook previous: nil ]
]

{ #category : 'accessing' }
ToWidgetSkinDep >> removeSubscription: aSubscription [

	subscriptions := subscriptions copyWithout: aSubscription
]

{ #category : 'event handling' }
ToWidgetSkinDep >> skinChangedEvent: anEvent [

	anEvent target childrenDo: [ :child | child updateSkin ]
]

{ #category : 'accessing' }
ToWidgetSkinDep >> subscriptions [

	^ subscriptions 
]

{ #category : 'event handling' }
ToWidgetSkinDep >> themeChangedEvent: anEvent [

	self launchSkinUninstallationIn: anEvent currentTarget.
	self launchSkinInstallationIn: anEvent currentTarget.	
	self launchSkinInitializationIn:  anEvent currentTarget.
]
