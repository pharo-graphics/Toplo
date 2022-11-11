Class {
	#name : #ToWidgetAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'widget'
	],
	#category : #'Toplo-Widget-Buttons'
}

{ #category : #accessing }
ToWidgetAnnouncement >> widget [

	^ widget
]

{ #category : #accessing }
ToWidgetAnnouncement >> widget: aWidget [

	widget := aWidget
]
