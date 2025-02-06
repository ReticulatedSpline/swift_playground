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

for payer in entries {
  // no adjustment necessary
  if payer.value == average {
    continue
  
  // only adjust when user underpaid
  } else if (payer.value < average) {
    var payer_delta = average - payer.value

    // adjust until they've reached the average expense
    while payer_delta > 0 {
      if let payee = entries.first(where: {$0.value > average}) {

        let payee_delta = payee.value - average
        
        // if they owe less than the recipient overpaid, zero out their debt
        if (payer_delta <= payee_delta) {
          print("\(payer.key) should pay \(payee.key) $\(payer_delta)")
          payer_delta = 0

        // else reduce debt just enough to zero out recipient owed sum
        } else {
          print("\(payer.key) should pay \(payee.key) $\(payee_delta)")
          payer_delta -= payee_delta
        }
      }
    }
  }
}

print("Per-user average was $\(average)")
print("Sum was $\(sum)")