import Foundation

print("""
			Enter name and expense total on each line, separated by a space.
			Press enter after each entry. Leave line blank to terminate input:\n
			""")

var raw_input = ""
var entries: [String:Float] = [:]
raw_input = readLine() ?? ""

repeat {
	let components = raw_input.split(separator: " ")
	if components.count == 2 {
		entries[String(components[0])] = Float(components[1]) ?? 0
	}
	raw_input = readLine() ?? ""
} while !raw_input.isEmpty

var sum: Float = 0;
for entry in entries {
	sum += entry.value
}
var average: Float = sum / Float(entries.count)

if entries.count < 2 {
	print("At least two parties are necessary to split an expense.")
	exit(0)
}

print("Sum was $\(String(format: "%.2f", sum))")
print("Per-user average was $\(String(format: "%.2f", average))")

var debtors = entries.filter { $0.value < average }
var recipients = entries.filter { $0.value > average }

for var debtor in debtors {
    for var recipient in recipients {
        let delta = min(recipient.value - average, average - debtor.value)
        print("\(debtor.key) should pay \(recipient.key) $\(String(format: "%.2f", delta))")
        
        debtor.value += delta
        recipient.value -= delta
        
        // remove balanced debtors from the list
        if debtor.value == average {
            if let index = debtors.firstIndex(where: { $0.key == debtor.key }) {
                debtors.remove(at: index)
            }
        }
        
        // remove balanced recipients from the list
        if recipient.value == average {
            if let index = recipients.firstIndex(where: { $0.key == recipient.key }) {
                recipients.remove(at: index)
            }
        }
        
        if debtors.isEmpty || recipients.isEmpty {
            break
        }
    }
}